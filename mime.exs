defmodule Mime do
  @external_resource Path.join([__DIR__,"mimetypes.txt"])

  defmacro __using__(opts) do
    quote do
      @mime_opts unquote(opts)
      import unquote(__MODULE__)
      @before_compile unquote(__MODULE__)
    end
  end

  defmacro __before_compile__(env) do
    mime_opts = Module.get_attribute(env.module, :mime_opts)
    res = Enum.map mime_opts, fn({k,v}) -> {Atom.to_string(k), v} end

    mimes_path = Mime.__info__(:attributes)[:external_resource]
    stream = File.stream!(mimes_path)

    mapping = Enum.flat_map(stream, fn (line) ->
      if String.starts_with?(line, ["#", "\n"]) do
        []
      else
        [type|exts] = line |> String.strip |> String.split
        [{type, exts}]
      end
    end)

    mappings = Enum.concat mapping, res
    compile(mappings)
  end

  defp compile(mappings) do
    mappings_ast = defmapping(mappings)
    final_ast = quote do
      unquote(mappings_ast)
      def exts_from_type(_type), do: []
      def type_from_ext(_ext), do: nil
      def valid_type?(type), do: exts_from_type(type) |> Enum.any?
    end

    final_ast
  end

  defp defmapping(mappings) do
    for {type, exts} <- mappings do
      quote do
        def exts_from_type(unquote(type)), do: unquote(exts)
        def type_from_ext(ext) when ext in unquote(exts), do: unquote(type)
      end
    end
  end
end
