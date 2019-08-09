defmodule CritistryWeb.Schema do
  use Absinthe.Schema
  import Absinthe.Resolution.Helpers, only: [dataloader: 1]

  alias CritistryWeb.Resolvers
  alias Critistry.Auth
  alias Critistry.Crits

  def plugins do
    [Absinthe.Middleware.Dataloader | Absinthe.Plugin.defaults()]
  end

  def dataloader() do
    Dataloader.new()
    |> Dataloader.add_source(Auth, Auth.data())
    |> Dataloader.add_source(Crits, Crits.data())
  end

  def context(ctx) do
    Map.put(ctx, :loader, dataloader())
  end

  query do
    field :user, :user do
      arg(:id, :id)
      resolve(&Resolvers.Auth.user/3)
    end

    field :users, list_of(:user) do
      resolve(&Resolvers.Auth.users/3)
    end

    field :crit_group, :crit_group do
      arg(:id, :id)
      resolve(&Resolvers.Crits.crit_group/3)
    end

    field :crit_groups, list_of(:crit_group) do
      resolve(&Resolvers.Crits.crit_groups/3)
    end

    field :crit_session, :crit_session do
      arg(:id, :id)
      resolve(&Resolvers.Crits.crit_session/3)
    end

    field :crit_sessions, list_of(:crit_session) do
      resolve(&Resolvers.Crits.crit_sessions/3)
    end

    field :crit, :crit do
      arg(:id, :id)
      resolve(&Resolvers.Crits.crit/3)
    end

    field :crits, list_of(:crit) do
      resolve(&Resolvers.Crits.crits/3)
    end
  end

  object :user do
    field(:id, :id)
    field(:avatar, :string)
    field(:email, :string)
    field(:user_name, :string)
    field(:first_name, :string)
    field(:last_name, :string)
    field(:bio, :string)
    field(:crit_groups, list_of(:crit_group), resolve: dataloader(Crits))
  end

  object :crit_group do
    field(:id, :id)
    field(:image, :string)
    field(:description, :string)
    field(:max_members, :integer)
    field(:name, :string)
    field(:session_duration_days, :integer)
    field(:admin_user, :user, resolve: dataloader(Auth))
    field(:users, list_of(:user), resolve: dataloader(Crits))
    field(:categories, list_of(:category), resolve: dataloader(Crits))
    field(:crit_sessions, list_of(:crit_session), resolve: dataloader(Crits))
  end

  object :crit_session do
    field(:id, :id)
    field(:name, :string)
    field(:description, :string)
    field(:image, :string)
    field(:user, :user, resolve: dataloader(Auth))
    field(:crit_group, :crit_group, resolve: dataloader(Crits))
    field(:crit, list_of(:crit), resolve: dataloader(Crits))
  end

  object :crit do
    field(:id, :id)
    field(:text, :string)
    field(:user, :user, resolve: dataloader(Auth))
    field(:crit_session, :crit_session, resolve: dataloader(Crits))
  end

  object :category do
    field(:id, :id)
    field(:name, :string)
  end
end
