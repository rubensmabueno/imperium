module API
  module V1
    class IssuesController < ApplicationController
      def index
        issues = IssueRepresenter.represent_items(current_client.issues('toptal/chewy', state: 'closed'))

        render json: issues.to_json
      end
    end
  end
end
