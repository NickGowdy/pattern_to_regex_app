defmodule Program do
  @moduledoc """
  This is a module that takes a pattern specification provided
  as a commandline arguement into a regex
  """
@doc """
  Says hello to the given `name`.

  Returns `:ok`.

  ## Examples

      iex> Program.main(:john)
      :ok

  """
  @spec main(nonempty_maybe_improper_list) :: Regex.t()
  def main(_args = [command | _commands]) do
   IO.inspect(command)
  end
end
