from brownie import accounts,SimpleStorage

def deploy_simple_storage():
    account = accounts[0] #as a part of the default value that brownie generates when it starts the ganache cli
    simple_storage = SimpleStorage.deploy({"from":account})
    storedval = simple_storage.watch()
    print(storedval)
    transaction = simple_storage.store(15,{"from":account})
    transaction.wait(1)
    storedval = simple_storage.watch()
    print(storedval)
    # account = accounts.load("test1acc")
    print(simple_storage)

def main():
    deploy_simple_storage()