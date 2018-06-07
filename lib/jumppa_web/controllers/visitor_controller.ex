defmodule JumppaWeb.VisitorController do
  use JumppaWeb, :controller

  alias Jumppa.People
  alias Jumppa.People.Visitor

  def index(conn, _params) do
    visitors = People.list_visitors()
    render(conn, "index.html", visitors: visitors)
  end

  def new(conn, _params) do
    changeset = People.change_visitor(%Visitor{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"visitor" => visitor_params}) do
    case People.create_visitor(visitor_params) do
      {:ok, visitor} ->
        conn
        |> put_flash(:info, "Visitor created successfully.")
        |> redirect(to: visitor_path(conn, :show, visitor))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    visitor = People.get_visitor!(id)
    render(conn, "show.html", visitor: visitor)
  end

  def edit(conn, %{"id" => id}) do
    visitor = People.get_visitor!(id)
    changeset = People.change_visitor(visitor)
    render(conn, "edit.html", visitor: visitor, changeset: changeset)
  end

  def update(conn, %{"id" => id, "visitor" => visitor_params}) do
    visitor = People.get_visitor!(id)

    case People.update_visitor(visitor, visitor_params) do
      {:ok, visitor} ->
        conn
        |> put_flash(:info, "Visitor updated successfully.")
        |> redirect(to: visitor_path(conn, :show, visitor))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", visitor: visitor, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    visitor = People.get_visitor!(id)
    {:ok, _visitor} = People.delete_visitor(visitor)

    conn
    |> put_flash(:info, "Visitor deleted successfully.")
    |> redirect(to: visitor_path(conn, :index))
  end
end
