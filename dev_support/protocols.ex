defimpl FunWithFlags.Actor, for: Map do
  def id(%{actor_id: actor_id}) do
    "map:#{actor_id}"
  end

  def id(map) do
    map
    |> inspect()
    |> (&:crypto.hash(:md5, &1)).()
    |> Base.encode16
    |> (&"map:#{&1}").()
  end
end


defimpl FunWithFlags.Actor, for: BitString do
  def id(str) do
    "string:#{str}"
  end
end

defimpl FunWithFlags.Group, for: BitString do
  def in?(str, group_name) do
    String.contains?(str, to_string(group_name))
  end
end


defimpl FunWithFlags.Group, for: Map do
  def in?(%{group: group_name}, group_name), do: true
  def in?(_, _), do: false
end


defmodule PlainUser do
  defstruct [:id, :group]
end

defimpl FunWithFlags.Actor, for: PlainUser do
  def id(%{id: id}) do
    "user:#{id}"
  end
end

defimpl FunWithFlags.Group, for: PlainUser do
  def in?(%{group: group}, group), do: true
  def in?(_, _), do: false
end
