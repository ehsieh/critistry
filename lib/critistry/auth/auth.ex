defmodule Critistry.Auth do
  import Ecto.Query, warn: false
  alias Critistry.Repo
  alias Critistry.Auth.User

  def find_or_create_user(info) do
    user = find_user_by_email info.email
    user = 
      if (user == nil) do
        {:ok, new_user} = create_user(info)
        new_user
      else
        user
      end    
    user
  end  

  def find_user_by_email(email) do
    user = Repo.get_by(User, email: email)
    user 
    |> Repo.preload(:crit_groups)
  end

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end

  def update_user(%User{} = user, attrs) do
    user 
    |> User.changeset(attrs)
    |> Repo.update()
  end
end
