# frozen_string_literal: true

# Licensed to the Software Freedom Conservancy (SFC) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The SFC licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.

require_relative '../spec_helper'

module Selenium
  module WebDriver
    module Chrome
      describe Service, exclusive: [{bidi: false, reason: 'Not yet implemented with BiDi'}, {browser: :chrome}] do
        let(:service) { described_class.new }
        let(:service_manager) { service.launch }

        after { service_manager.stop }

        it 'auto uses chromedriver' do
          service.executable_path = DriverFinder.new(Options.new, described_class.new).driver_path

          expect(service_manager.uri).to be_a(URI)
        end

        it 'can be started outside driver' do
          expect(service_manager.uri).to be_a(URI)
        end

        context 'with a path env variable' do
          before { ENV['SE_CHROMEDRIVER'] = DriverFinder.new(Options.new, described_class.new).driver_path }

          after { ENV.delete('SE_CHROMEDRIVER') }

          it 'uses the path from the environment' do
            expect(service.executable_path).to match(/chromedriver/)
          end

          it 'updates the path after setting the environment variable' do
            ENV['SE_CHROMEDRIVER'] = '/foo/bar'
            service.executable_path = DriverFinder.new(Options.new, described_class.new).driver_path

            expect(service.executable_path).to match(/chromedriver/)
          end
        end
      end
    end # Chrome
  end # WebDriver
end # Selenium
