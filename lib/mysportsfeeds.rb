require "mysportsfeeds/api/API_v1_0"

### Main class for all interaction with the MySportsFeeds API
class MySportsFeeds

    # Constructor
    def initialize(version='1.0', verbose=False, store_type='file', store_location='results/')
        __verify_version(version)
        __verify_store(store_type, store_location)

        @version = version
        @verbose = verbose
        @store_type = store_type
        @store_location = store_location

        # Instantiate an instance of the appropriate API depending on version
        if @version == '1.0'
            @api_instance = Mysportsfeeds::Api::API_v1_0.new(@verbose, @store_type, @store_location)
        end
    end

    # Make sure the version is supported
    def __verify_version(version)
        if version != '1.0'
            raise Exception.new("Unrecognized version specified.  Supported versions are: '1.0'")
        end
    end

    # Verify the type and location of the stored data
    def __verify_store(store_type, store_location)
        if !store_type.nil? and store_type != 'file'
            raiseException.new("Unrecognized storage type specified.  Supported values are: nil,'file'")
        end

        if store_type == 'file'
            if store_location.nil?
                raise Exception.new("Must specify a location for stored data.")
        	end
        end
    end

    # Authenticate against the API (for v1.0)
    def authenticate(username, password)
        if !@api_instance.supports_basic_auth()
            raise Exception.new("BASIC authentication not supported for version " + @version)
        end

        @api_instance.set_auth_credentials(username, password)
    end

    # Request data (and store it if applicable)
    def msf_get_data(league, season, feed, output_format, *kwargs)
        return @api_instance.get_data(league, season, feed, output_format, kwargs)
    end
end
