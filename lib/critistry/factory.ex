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
    %Critistry.Crits.CritGroup{      
      admin_user_id: 1,
      approval_to_join: sequence(:approval_to_join, [true, false]),
      image: "",
      description: Elixilorem.sentence,
      is_private: sequence(:is_private, [true, false]),
      max_members: sequence(:max_members, [4, 6, 8, 10]),
      name: Elixilorem.words(4),
      session_duration_days: sequence(:session_duration_days, [5, 7, 10, 14])
    }
  end

  def crit_session_factory do
    %Critistry.Crits.CritSession{
      description: Elixilorem.sentence,      
      image: "",
      is_active: sequence(:is_active, [true, false]),
      name: Elixilorem.words(4)    
    }
  end
end