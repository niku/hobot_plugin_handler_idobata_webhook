defmodule Hobot.Plugin.Handler.Idobata.WebhookTest do
  use ExUnit.Case
  doctest Hobot.Plugin.Handler.Idobata.Webhook

  test "greets the world" do
    assert Hobot.Plugin.Handler.Idobata.Webhook.hello() == :world
  end
end
