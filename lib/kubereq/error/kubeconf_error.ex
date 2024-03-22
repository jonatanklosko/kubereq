defmodule Kubereq.Error.KubeconfError do
  @moduledoc """
  Indicates an error with the Kubernetes Configuration
  """

  @enforce_keys [:message, :code]
  defexception [:message, :code, upstream: nil]

  @type t :: %__MODULE__{
          __exception__: true,
          message: String.t(),
          code: atom(),
          upstream: Exception.t()
        }

  @errors %{
    config_already_set: "The Kubernetes configuration is already set.",
    cert_prep_failed: "Failed to prepare the certificate data.",
    exec_conf_decode_failed: "Failed to decode the exec configuration",
    env_var_empty: "The given ENV variable is empty"
  }

  @spec new(atom(), Exception.t() | nil) :: t()
  def new(code, upstream \\ nil)

  for {code, message} <- @errors do
    def new(unquote(code), upstream) do
      struct!(__MODULE__, code: unquote(code), message: unquote(message), upstream: upstream)
    end
  end
end
