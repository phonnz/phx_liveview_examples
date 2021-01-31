defmodule LiveExamplesWeb.CounterLiveTest do
  use LiveExamplesWeb.ConnCase

  import Phoenix.LiveViewTest

  alias LiveExamples.Counters

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  defp fixture(:counter) do
    {:ok, counter} = Counters.create_counter(@create_attrs)
    counter
  end

  defp create_counter(_) do
    counter = fixture(:counter)
    %{counter: counter}
  end

  describe "Index" do
    setup [:create_counter]

    test "lists all counters", %{conn: conn, counter: counter} do
      {:ok, _index_live, html} = live(conn, Routes.counter_index_path(conn, :index))

      assert html =~ "Listing Counters"
    end

    test "saves new counter", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.counter_index_path(conn, :index))

      assert index_live |> element("a", "New Counter") |> render_click() =~
               "New Counter"

      assert_patch(index_live, Routes.counter_index_path(conn, :new))

      assert index_live
             |> form("#counter-form", counter: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#counter-form", counter: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.counter_index_path(conn, :index))

      assert html =~ "Counter created successfully"
    end

    test "updates counter in listing", %{conn: conn, counter: counter} do
      {:ok, index_live, _html} = live(conn, Routes.counter_index_path(conn, :index))

      assert index_live |> element("#counter-#{counter.id} a", "Edit") |> render_click() =~
               "Edit Counter"

      assert_patch(index_live, Routes.counter_index_path(conn, :edit, counter))

      assert index_live
             |> form("#counter-form", counter: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#counter-form", counter: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.counter_index_path(conn, :index))

      assert html =~ "Counter updated successfully"
    end

    test "deletes counter in listing", %{conn: conn, counter: counter} do
      {:ok, index_live, _html} = live(conn, Routes.counter_index_path(conn, :index))

      assert index_live |> element("#counter-#{counter.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#counter-#{counter.id}")
    end
  end

  describe "Show" do
    setup [:create_counter]

    test "displays counter", %{conn: conn, counter: counter} do
      {:ok, _show_live, html} = live(conn, Routes.counter_show_path(conn, :show, counter))

      assert html =~ "Show Counter"
    end

    test "updates counter within modal", %{conn: conn, counter: counter} do
      {:ok, show_live, _html} = live(conn, Routes.counter_show_path(conn, :show, counter))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Counter"

      assert_patch(show_live, Routes.counter_show_path(conn, :edit, counter))

      assert show_live
             |> form("#counter-form", counter: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#counter-form", counter: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.counter_show_path(conn, :show, counter))

      assert html =~ "Counter updated successfully"
    end
  end
end
