defmodule Hobot.Plugin.Handler.Idobata.Webhook do
  @moduledoc """
  Documentation for Hobot.Plugin.Handler.Idobata.Webhook.
  """

  use GenServer

  def init({context, config} = args) do
    for {topic, _builder} <- config, do: apply(context.subscribe, [topic])
    {:ok, args}
  end

  def handle_cast({:broadcast, topic, _ref, data}, {_context, config} = state) do
    url =
      Map.fetch!(config, topic)
      |> Map.fetch!(:url)
    url = case url do
            u when is_binary(u) ->
              String.to_charlist(u)
            u when is_list(u) ->
              u
          end
    :httpc.request(
      :post,
      {
        url,
        [],
        'application/x-www-form-urlencoded',
        URI.encode_query(source: data, format: :html),
      },
      [],
      []
    )
    {:noreply, state}
  end

  def terminate(reason, {context, config}) do
    for {topic, _builder} <- config, do: apply(context.unsubscribe, [topic])
    reason
  end
end
