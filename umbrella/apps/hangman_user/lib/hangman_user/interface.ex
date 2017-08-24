defmodule HangmanUser.Interface do

  def register(username, password) do
    HangmanGame.Server.register(username, password)
  end

  def login(username, password) do
    HangmanGame.Server.login(username, password)
  end

  def create_room(roomname, username) do
    Data.Room.Queries.add_user_to_room(roomname, username)
  end

  def enter_room(roomname, username) do
    
  end

  def add_word(word, username, roomname) do
    Data.Word.Queries.add_word(word, username, roomname)
  end
  
end