defmodule Critistry.Factory do
  use ExMachina.Ecto, repo: Critistry.Repo

  def user_factory do
    %Critistry.Auth.User{
      first_name: "Eric",      
      email: sequence(:email, &"email-#{&1}@example.com"),
      bio: Elixilorem.sentence
    }
  end

  def crit_group_factory do
    
  end
end