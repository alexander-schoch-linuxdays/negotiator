defmodule Negotiator do
  @moduledoc """
  Documentation for `Negotiator`.
  """

  @doc """

  """
  def locale_plug(conn) do
    conn
    |> IO.inspect
  end

  @doc """
  Given the Accept-Lanuage header and a list of available locales, this function
  returns the best match for a locale by this logic:

  - if any accept-lanuage header locale matches an available locale, pick the one
    with the highest `q` value
  - if none match, return the default locale (if given) or the first option of
    `available_locales`
  """
  def negotiate_locale(accept_language_header, available_languages, opts \\ [])

  def negotiate_locale({"accept-language", _accept_language}, [], _opts) do
    raise ArgumentError, "the `available_locales` cannot be empty"  
  end

  def negotiate_locale({"accept-language", accept_language}, available_locales, opts) do
    sort_func = fn a, b ->
      left_prio =
        if a |> String.contains?(";") do
          a |> String.split("=") |> Enum.at(1) |> String.to_float()
        else
          1
        end

      right_prio =
        if b |> String.contains?(";") do
          b |> String.split("=") |> Enum.at(1) |> String.to_float()
        else
          1
        end

      left_prio > right_prio
    end

    IO.inspect(opts)

    choices =
      accept_language
      |> String.split(",")
      |> Enum.sort_by(& &1, sort_func)
      |> Enum.map(fn x -> x |> String.split(";") |> Enum.at(0) end)
      |> Enum.map(fn x -> x |> String.split("-") |> Enum.at(0) end)

    matches = choices |> Enum.filter(fn x -> available_locales |> Enum.member?(x) end)

    case matches do
      [] -> case Keyword.fetch(opts, :default) do
        {:ok, default} -> default
        :error -> available_locales |> Enum.at(0)
      end
      m -> m |> Enum.at(0)
    end
  end
end
