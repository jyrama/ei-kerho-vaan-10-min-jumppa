defmodule Jumppa.PeopleTest do
  use Jumppa.DataCase

  alias Jumppa.People

  describe "visitors" do
    alias Jumppa.People.Visitor

    @valid_attrs %{address: "some address", first_name: "some first_name", last_name: "some last_name", municipality: "some municipality", zip: "some zip"}
    @update_attrs %{address: "some updated address", first_name: "some updated first_name", last_name: "some updated last_name", municipality: "some updated municipality", zip: "some updated zip"}
    @invalid_attrs %{address: nil, first_name: nil, last_name: nil, municipality: nil, zip: nil}

    def visitor_fixture(attrs \\ %{}) do
      {:ok, visitor} =
        attrs
        |> Enum.into(@valid_attrs)
        |> People.create_visitor()

      visitor
    end

    test "list_visitors/0 returns all visitors" do
      visitor = visitor_fixture()
      assert People.list_visitors() == [visitor]
    end

    test "get_visitor!/1 returns the visitor with given id" do
      visitor = visitor_fixture()
      assert People.get_visitor!(visitor.id) == visitor
    end

    test "create_visitor/1 with valid data creates a visitor" do
      assert {:ok, %Visitor{} = visitor} = People.create_visitor(@valid_attrs)
      assert visitor.address == "some address"
      assert visitor.first_name == "some first_name"
      assert visitor.last_name == "some last_name"
      assert visitor.municipality == "some municipality"
      assert visitor.zip == "some zip"
    end

    test "create_visitor/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = People.create_visitor(@invalid_attrs)
    end

    test "update_visitor/2 with valid data updates the visitor" do
      visitor = visitor_fixture()
      assert {:ok, visitor} = People.update_visitor(visitor, @update_attrs)
      assert %Visitor{} = visitor
      assert visitor.address == "some updated address"
      assert visitor.first_name == "some updated first_name"
      assert visitor.last_name == "some updated last_name"
      assert visitor.municipality == "some updated municipality"
      assert visitor.zip == "some updated zip"
    end

    test "update_visitor/2 with invalid data returns error changeset" do
      visitor = visitor_fixture()
      assert {:error, %Ecto.Changeset{}} = People.update_visitor(visitor, @invalid_attrs)
      assert visitor == People.get_visitor!(visitor.id)
    end

    test "delete_visitor/1 deletes the visitor" do
      visitor = visitor_fixture()
      assert {:ok, %Visitor{}} = People.delete_visitor(visitor)
      assert_raise Ecto.NoResultsError, fn -> People.get_visitor!(visitor.id) end
    end

    test "change_visitor/1 returns a visitor changeset" do
      visitor = visitor_fixture()
      assert %Ecto.Changeset{} = People.change_visitor(visitor)
    end
  end
end
