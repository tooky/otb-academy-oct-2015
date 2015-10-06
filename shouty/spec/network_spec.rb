require 'shouty'
RSpec.describe Network do
  it "broadcast messages to all subscribers" do
    network = Network.new

    lucy = double("lucy")
    pam = double("pam")

    network.subscribe(lucy)
    network.subscribe(pam)

    message = "Free Toast!"

    expect(lucy).to receive(:hear).with(message)
    expect(pam).to receive(:hear).with(message)

    network.broadcast(message)
  end
end
