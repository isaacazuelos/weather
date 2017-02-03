defmodule CLITest do
  use ExUnit.Case
  
  import ExUnit.CaptureIO
  import Weather.CLI

  ## Weather.CLI.parse_args/1
  
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

  ## Weather.CLI.process/1

  test "print usage with given :usage" do
    assert capture_io(fn ->
      process(:usage)
    end) |> String.starts_with?("Usage:")
  end

  test "print something when given :help" do
        assert capture_io(fn ->
      process(:usage)
    end) != ""
  end
end
