defmodule KoyalReminderWeb.Layouts do
  @moduledoc """
  This module holds different layouts used by your application.

  See the `layouts` directory for all templates available.
  The "root" layout is a skeleton rendered as part of the
  application router. The "app" layout is set as the default
  layout on both `use KoyalReminderWeb, :controller` and
  `use KoyalReminderWeb, :live_view`.
  """
  use KoyalReminderWeb, :html

  embed_templates "layouts/*"
end
