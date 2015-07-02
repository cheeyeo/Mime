ExUnit.start
Code.require_file("mime.exs", __DIR__)

defmodule MimeTest do
  use ExUnit.Case

  defmodule MimeTest do
    use Mime, "text/emoji": [".emj"], "text/elixir": [".exs",".ex"]
  end

  test "it should be able to determine the exts from type" do
    assert MimeTest.exts_from_type("text/html") == ["html", "htm"]
  end

  test "it should be able to determine type from exts" do
    assert MimeTest.type_from_ext("html") == "text/html"
    assert MimeTest.type_from_ext("htm") == "text/html"
  end

  test "it should return empty array for invalid exts" do
    assert MimeTest.exts_from_type("rubbish") == []
  end

  test "it should return nil for invalid exts" do
    assert MimeTest.type_from_ext("rubbish") == nil
  end

  test "it should return true for valid types" do
    assert MimeTest.valid_type?("text/html")
  end

  test "it should return false for invalid types" do
    refute MimeTest.valid_type?("rubbish")
  end

  test "it should register user defined types" do
    assert MimeTest.exts_from_type("text/emoji") == [".emj"]
    assert MimeTest.exts_from_type("text/elixir") == [".exs", ".ex"]
  end
end
