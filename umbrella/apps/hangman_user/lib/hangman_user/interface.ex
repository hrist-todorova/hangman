defmodule HangmanUser.Interface do

  def register(username, password) do
    HangmanGame.Server.register(username, password)
  end

  def login(username, password) do
    HangmanGame.Server.login(username, password)
  end

  def create_room(name) do
    
  end

  def enter_room(name) do
    
  end
  
end