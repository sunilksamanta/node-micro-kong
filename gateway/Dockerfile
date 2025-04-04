FROM kong:3.4

USER root

# Install dependencies
RUN apt-get update && \
    apt-get install -y git unzip curl luarocks && \
    apt-get clean

# Clone the plugin repo
RUN git clone https://github.com/revomatico/kong-oidc.git && \
    cd kong-oidc && \
    # Make it compatible with Kong 3.x by removing base_plugin dependency
    sed -i 's/local BasePlugin = require "kong.plugins.base_plugin"/-- local BasePlugin = require "kong.plugins.base_plugin"/' kong/plugins/oidc/handler.lua && \
    sed -i 's/local OidcHandler = BasePlugin:extend()/local OidcHandler = {}/' kong/plugins/oidc/handler.lua && \
    # Install the plugin
    luarocks make

USER kong