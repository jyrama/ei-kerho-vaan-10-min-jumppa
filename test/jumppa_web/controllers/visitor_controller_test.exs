defmodule JumppaWeb.VisitorControllerTest do
  use JumppaWeb.ConnCase

  alias Jumppa.People

  @create_attrs %{address: "some address", first_name: "some first_name", last_name: "some last_name", municipality: "some municipality", zip: "some zip"}
  @update_attrs %{address: "some updated address", first_name: "some updated first_name", last_name: "some updated last_name", municipality: "some updated municipality", zip: "some updated zip"}
  @invalid_attrs %{address: nil, first_name: nil, last_name: nil, municipality: nil, zip: nil}

  def fixture(:visitor) do
    {:ok, visitor} = People.create_visitor(@create_attrs)
    visitor
  end

  describe "index" do
    test "lists all visitors", %{conn: conn} do
      conn = get conn, visitor_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Visitors"
    end
  end

  describe "new visitor" do
    test "renders form", %{conn: conn} do
      conn = get conn, visitor_path(conn, :new)
      assert html_response(conn, 200) =~ "New Visitor"
    end
  end

  describe "create visitor" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, visitor_path(conn, :create), visitor: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == visitor_path(conn, :show, id)

      conn = get conn, visitor_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Visitor"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, visitor_path(conn, :create), visitor: @invalid_attrs
      assert html_response(conn, 200) =~ "New Visitor"
    end
  end

  describe "edit visitor" do
    setup [:create_visitor]

    test "renders form for editing chosen visitor", %{conn: conn, visitor: visitor} do
      conn = get conn, visitor_path(conn, :edit, visitor)
      assert html_response(conn, 200) =~ "Edit Visitor"
    end
  end

  describe "update visitor" do
    setup [:create_visitor]

    test "redirects when data is valid", %{conn: conn, visitor: visitor} do
      conn = put conn, visitor_path(conn, :update, visitor), visitor: @update_attrs
      assert redirected_to(conn) == visitor_path(conn, :show, visitor)

      conn = get conn, visitor_path(conn, :show, visitor)
      assert html_response(conn, 200) =~ "some updated address"
    end

    test "renders errors when data is invalid", %{conn: conn, visitor: visitor} do
      conn = put conn, visitor_path(conn, :update, visitor), visitor: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Visitor"
    end
  end

  describe "delete visitor" do
    setup [:create_visitor]

    test "deletes chosen visitor", %{conn: conn, visitor: visitor} do
      conn = delete conn, visitor_path(conn, :delete, visitor)
      assert redirected_to(conn) == visitor_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, visitor_path(conn, :show, visitor)
      end
    end
  end

  defp create_visitor(_) do
    visitor = fixture(:visitor)
    {:ok, visitor: visitor}
  end
end
