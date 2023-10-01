defmodule WebGamesWeb.MinesweeperComponents do
  use WebGamesWeb, :html

  def grid(assigns) do
    ~H"""
    <table id="grid">
      <tr :for={row <- 0..(@width-1)}>
        <td :for={column <- 0..(@height-1)}>
          <.cell cell={@grid[{column, row}]} x={column} y={row} />
        </td>
      </tr>
    </table>
    """
  end

  def cell(assigns) do
    ~H"""
    <div class={"w-8 h-8 #{@cell.background_color} #{@cell.text_color} #{@cell.border_color} border"}
      phx-click="click"
      phx-value-x={@x}
      phx-value-y={@y}
      disabled={not @cell.clickable?}
    >
      <%= @cell.value %>
    </div>
    """
  end
end
