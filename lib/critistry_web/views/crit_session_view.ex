defmodule CritistryWeb.CritSessionView do
  use CritistryWeb, :view

  alias Critistry.Crits

  def member?(crit_group_id, user) do
    crit_group = Crits.get_crit_group!(crit_group_id)
    Crits.crit_group_member?(crit_group, user)
  end
end
