defmodule CritistryWeb.CritGroupView do
  use CritistryWeb, :view

  alias Critistry.Crits

  def member?(crit_group, user) do
    Crits.crit_group_member?(crit_group, user)
  end
end
