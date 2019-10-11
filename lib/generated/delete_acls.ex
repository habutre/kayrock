defmodule(Kayrock.DeleteAcls) do
  @moduledoc false
  _ = " THIS CODE IS GENERATED BY KAYROCK"

  defmodule(V0.Request) do
    @moduledoc false
    _ = " THIS CODE IS GENERATED BY KAYROCK"
    defstruct(filters: [], correlation_id: nil, client_id: nil)
    import(Elixir.Kayrock.Serialize)
    @type t :: %__MODULE__{}
    def(api_key) do
      Kayrock.KafkaSchemaMetadata.api_key(:delete_acls)
    end

    def(api_vsn) do
      0
    end

    def(response_deserializer) do
      &V0.Response.deserialize/1
    end

    def(schema) do
      [
        filters:
          {:array,
           [
             resource_type: :int8,
             resource_name: :nullable_string,
             principal: :nullable_string,
             host: :nullable_string,
             operation: :int8,
             permission_type: :int8
           ]}
      ]
    end

    def(serialize(%V0.Request{} = struct)) do
      [
        <<api_key()::16, api_vsn()::16, struct.correlation_id()::32,
          byte_size(struct.client_id())::16, struct.client_id()::binary>>,
        [
          case(Map.fetch!(struct, :filters)) do
            nil ->
              <<-1::32-signed>>

            [] ->
              <<0::32-signed>>

            vals when is_list(vals) ->
              [
                <<length(vals)::32-signed>>,
                for(v <- vals) do
                  [
                    serialize(:int8, Map.fetch!(v, :resource_type)),
                    serialize(:nullable_string, Map.fetch!(v, :resource_name)),
                    serialize(:nullable_string, Map.fetch!(v, :principal)),
                    serialize(:nullable_string, Map.fetch!(v, :host)),
                    serialize(:int8, Map.fetch!(v, :operation)),
                    serialize(:int8, Map.fetch!(v, :permission_type))
                  ]
                end
              ]
          end
        ]
      ]
    end
  end

  defimpl(Elixir.Kayrock.Request, for: V0.Request) do
    def(serialize(%V0.Request{} = struct)) do
      try do
        V0.Request.serialize(struct)
      rescue
        e ->
          reraise(Kayrock.InvalidRequestError, {e, struct}, __STACKTRACE__)
      end
    end

    def(api_vsn(%V0.Request{})) do
      V0.Request.api_vsn()
    end

    def(response_deserializer(%V0.Request{})) do
      V0.Request.response_deserializer()
    end
  end

  def(get_request_struct(0)) do
    %V0.Request{}
  end

  defmodule(V0.Response) do
    @moduledoc false
    _ = " THIS CODE IS GENERATED BY KAYROCK"
    defstruct(throttle_time_ms: nil, filter_responses: [], correlation_id: nil)
    @type t :: %__MODULE__{}
    import(Elixir.Kayrock.Deserialize)

    def(api_key) do
      Kayrock.KafkaSchemaMetadata.api_key(:delete_acls)
    end

    def(api_vsn) do
      0
    end

    def(schema) do
      [
        throttle_time_ms: :int32,
        filter_responses:
          {:array,
           [
             error_code: :int16,
             error_message: :nullable_string,
             matching_acls:
               {:array,
                [
                  error_code: :int16,
                  error_message: :nullable_string,
                  resource_type: :int8,
                  resource_name: :string,
                  principal: :string,
                  host: :string,
                  operation: :int8,
                  permission_type: :int8
                ]}
           ]}
      ]
    end

    def(deserialize(data)) do
      <<correlation_id::32-signed, rest::binary>> = data

      deserialize_field(
        :root,
        :throttle_time_ms,
        %__MODULE__{correlation_id: correlation_id},
        rest
      )
    end

    defp(deserialize_field(:root, :throttle_time_ms, acc, data)) do
      {val, rest} = deserialize(:int32, data)
      deserialize_field(:root, :filter_responses, Map.put(acc, :throttle_time_ms, val), rest)
    end

    defp(deserialize_field(:filter_responses, :error_code, acc, data)) do
      {val, rest} = deserialize(:int16, data)
      deserialize_field(:filter_responses, :error_message, Map.put(acc, :error_code, val), rest)
    end

    defp(deserialize_field(:filter_responses, :error_message, acc, data)) do
      {val, rest} = deserialize(:nullable_string, data)

      deserialize_field(
        :filter_responses,
        :matching_acls,
        Map.put(acc, :error_message, val),
        rest
      )
    end

    defp(deserialize_field(:matching_acls, :error_code, acc, data)) do
      {val, rest} = deserialize(:int16, data)
      deserialize_field(:matching_acls, :error_message, Map.put(acc, :error_code, val), rest)
    end

    defp(deserialize_field(:matching_acls, :error_message, acc, data)) do
      {val, rest} = deserialize(:nullable_string, data)
      deserialize_field(:matching_acls, :resource_type, Map.put(acc, :error_message, val), rest)
    end

    defp(deserialize_field(:matching_acls, :resource_type, acc, data)) do
      {val, rest} = deserialize(:int8, data)
      deserialize_field(:matching_acls, :resource_name, Map.put(acc, :resource_type, val), rest)
    end

    defp(deserialize_field(:matching_acls, :resource_name, acc, data)) do
      {val, rest} = deserialize(:string, data)
      deserialize_field(:matching_acls, :principal, Map.put(acc, :resource_name, val), rest)
    end

    defp(deserialize_field(:matching_acls, :principal, acc, data)) do
      {val, rest} = deserialize(:string, data)
      deserialize_field(:matching_acls, :host, Map.put(acc, :principal, val), rest)
    end

    defp(deserialize_field(:matching_acls, :host, acc, data)) do
      {val, rest} = deserialize(:string, data)
      deserialize_field(:matching_acls, :operation, Map.put(acc, :host, val), rest)
    end

    defp(deserialize_field(:matching_acls, :operation, acc, data)) do
      {val, rest} = deserialize(:int8, data)
      deserialize_field(:matching_acls, :permission_type, Map.put(acc, :operation, val), rest)
    end

    defp(deserialize_field(:matching_acls, :permission_type, acc, data)) do
      {val, rest} = deserialize(:int8, data)
      deserialize_field(:matching_acls, nil, Map.put(acc, :permission_type, val), rest)
    end

    defp(deserialize_field(:filter_responses, :matching_acls, acc, data)) do
      <<num_elements::32-signed, rest::binary>> = data

      {vals, rest} =
        if(num_elements > 0) do
          Enum.reduce(1..num_elements, {[], rest}, fn _ix, {acc, d} ->
            {val, r} = deserialize_field(:matching_acls, :error_code, %{}, d)
            {[val | acc], r}
          end)
        else
          {[], rest}
        end

      deserialize_field(
        :filter_responses,
        nil,
        Map.put(acc, :matching_acls, Enum.reverse(vals)),
        rest
      )
    end

    defp(deserialize_field(:root, :filter_responses, acc, data)) do
      <<num_elements::32-signed, rest::binary>> = data

      {vals, rest} =
        if(num_elements > 0) do
          Enum.reduce(1..num_elements, {[], rest}, fn _ix, {acc, d} ->
            {val, r} = deserialize_field(:filter_responses, :error_code, %{}, d)
            {[val | acc], r}
          end)
        else
          {[], rest}
        end

      deserialize_field(:root, nil, Map.put(acc, :filter_responses, Enum.reverse(vals)), rest)
    end

    defp(deserialize_field(_, nil, acc, rest)) do
      {acc, rest}
    end
  end

  def(deserialize(0, data)) do
    V0.Response.deserialize(data)
  end

  def(min_vsn) do
    0
  end

  def(max_vsn) do
    0
  end
end
