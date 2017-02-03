defmodule CLITest do
  use ExUnit.Case

  import Weather.CLI, only: [ parse_args: 1 ]

  test ":help is returned by -h and --help" do
    assert parse_args(["-h", "anything"]) == :help
    assert parse_args(["--help", "anything"]) == :help
  end

  test "nil returned if no arguments given" do
    assert parse_args([]) == nil
  end

  test ":usage is returned if there are unexpected arguments" do
    assert parse_args(["extra_positional"]) == :usage
    assert parse_args(["--extra_flag"]) == :usage
  end
end
