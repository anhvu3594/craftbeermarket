module API
  module V1
    class Test < Grape::API
      include API::V1::Defaults

      resource :test do
        desc "Return 1"
        get "", root: :graduates do
          1
        end
      end
    end
  end
end
