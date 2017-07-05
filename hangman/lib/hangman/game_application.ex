defmodule Hangman.Application do
  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

  #  :ets.new(:words, [:named_table, :public])
    :ets.new(:users, [:named_table, :public])

    children = [
     worker(Hangman.Room, []),
     worker(Hangman.Words, []),
     worker(Hangman.Users, [])
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Hangman.Supervisor]
    Supervisor.start_link(children, opts)

  end
end