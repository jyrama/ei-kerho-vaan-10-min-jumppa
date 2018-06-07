defmodule Jumppa.People.Visitor do
  use Ecto.Schema
  import Ecto.Changeset


  schema "visitors" do
    field :address, :string
    field :first_name, :string
    field :last_name, :string
    field :municipality, :string
    field :zip, :string

    timestamps()
  end

  @doc false
  def changeset(visitor, attrs) do
    visitor
    |> cast(attrs, [:first_name, :last_name, :address, :zip, :municipality])
    |> validate_required([:first_name, :last_name, :address, :zip, :municipality])
  end
end
