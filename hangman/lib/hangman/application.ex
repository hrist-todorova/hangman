defmodule Hangman.Application do
  use Application

  @moduledoc """
  Starts the application
  """

  def start(_type, _args) do
    import Supervisor.Spec, warn: false
    
    children = [
      supervisor(Users.Repo, []),
      worker(Hangman.Users, []),
      worker(Hangman.Words, []),
      worker(Hangman.Rooms, [])
    ]

    opts = [strategy: :one_for_one, name: Hangman.Supervisor]
    Supervisor.start_link(children, opts)
  end
end