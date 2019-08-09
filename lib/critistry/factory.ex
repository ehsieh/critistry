defmodule Critistry.Factory do
  use ExMachina.Ecto, repo: Critistry.Repo

  def user_factory do
    %Critistry.Auth.User{
      avatar: sequence(:avatar, &"/images/avatars/avatar-#{&1}.png"),
      first_name: Elixilorem.words(1),
      last_name: Elixilorem.words(1),
      user_name: sequence(:user_name, &"#{Elixilorem.words(1)}_#{&1}"),
      email: sequence(:email, &"email-#{&1}@example.com"),
      bio: Elixilorem.paragraph()
    }
  end

  def crit_group_factory do
    %Critistry.Crits.CritGroup{
      image: sequence(:group_image, &"/images/crit-groups/crit-group-#{&1}.jpg"),
      description: Elixilorem.paragraph(),
      max_members: sequence(:max_members, [4, 6, 8, 10]),
      name: Elixilorem.sentence(),
      session_duration_days: sequence(:session_duration_days, [5, 7, 10, 14])
    }
  end

  def crit_session_factory do
    %Critistry.Crits.CritSession{
      image: sequence(:session_image, &"/images/crit-sessions/crit-session-#{&1}.jpg"),
      description: Elixilorem.paragraph(),
      name: Elixilorem.sentence()
    }
  end

  def crit_factory do
    %Critistry.Crits.Crit{
      text: Elixilorem.paragraphs()
    }
  end

  def category_factory do
    %Critistry.Crits.Category{
      name: Elixilorem.words(2)
    }
  end
end
