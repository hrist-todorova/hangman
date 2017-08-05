defmodule Hangman.Application do
  use Application

  @moduledoc """
    Starts the application
  """

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

  #  :ets.new(:words, [:named_table, :public])
  #  :ets.new(:users, [:named_table, :public])

    children = [
      worker(Hangman.Users, [])
      #worker(Hangman.Room, []),
      #worker(Hangman.Words, [])
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Hangman.Supervisor]
    Supervisor.start_link(children, opts)

  end
end