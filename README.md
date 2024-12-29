# Web3 DApp Wallet

This project demonstrates a decentralized wallet application (DApp) using Web3 technologies, Truffle, Ganache, and Flutter. The wallet allows users to deposit and withdraw Ether, as well as view their transaction history.

## Features
- **Deposit Ether:** Add funds to your wallet.
- **Withdraw Ether:** Remove funds from your wallet.
- **Transaction History:** View past deposits and withdrawals.
- **Real-time Balance Updates:** Get the latest wallet balance.

---

## Prerequisites

To run this project, ensure you have the following installed:

1. **Ganache**: For creating a local blockchain.
2. **Truffle**: For compiling and deploying smart contracts.
3. **Flutter**: For developing the front-end application.
4. **Node.js**: For running Truffle and other dependencies.

---

## Getting Started

### Step 1: Clone the Repository
```bash
git clone <repository-url>
cd <repository-folder>
```

### Step 2: Install Dependencies
```bash
npm install
```

### Step 3: Start Ganache
```bash
ganache-cli
```
Ensure Ganache is running on `http://127.0.0.1:7545`.

### Step 4: Compile and Deploy Smart Contract
```bash
truffle compile
truffle migrate
```
This will compile and deploy the smart contract to your local blockchain.

---

## Flutter Application Setup

### Step 1: Install Flutter Dependencies
Navigate to the Flutter project directory and install dependencies:
```bash
flutter pub get
```

### Step 2: Run the Application
Ensure a device is connected or an emulator is running, then:
```bash
flutter run
```

---

## Configuration

### Smart Contract ABI and Address
Update the Flutter project with the deployed contract's ABI and address:
- Add the `ExpenseManagerContract.json` file to the `assets` folder.
- Replace the contract address in the `DashboardBloc` class:
```dart
_contractAddress = EthereumAddress.fromHex("<your-contract-address>");
```

---

## Commands Overview

### Start Local Blockchain
```bash
ganache-cli
```

### Compile Contracts
```bash
truffle compile
```

### Deploy Contracts
```bash
truffle migrate
```

### Run Flutter Application
```bash
flutter run
```

---

## Code Snippets

### Deposit Function in Flutter
```dart
FutureOr<void> dashboardDepositEvent(
    DashboardDepositEvent event, Emitter<DashboardState> emit) async {
  try {
    final transaction = Transaction.callContract(
        from: EthereumAddress.fromHex(
            "use you address"),
        contract: _deployedContract,
        function: _deposit,
        parameters: [
          BigInt.from(event.transactionModel.amount),
          event.transactionModel.reason
        ],
        value: EtherAmount.inWei(BigInt.from(event.transactionModel.amount)));

    final result = await _web3Client!.sendTransaction(_creds, transaction,
        chainId: 1337, fetchChainIdFromNetworkId: false);
    log(result.toString());
    add(DashboardInitialFechEvent());
  } catch (e) {
    log(e.toString());
  }
}
```

### Withdraw Function in Flutter
```dart
FutureOr<void> dashboardWithdrawEvent(
    DashboardWithdrawEvent event, Emitter<DashboardState> emit) async {
  try {
    final transaction = Transaction.callContract(
      from: EthereumAddress.fromHex(
          "......"),
      contract: _deployedContract,
      function: _withdraw,
      parameters: [
        BigInt.from(event.transactionModel.amount),
        event.transactionModel.reason
      ],
    );

    final result = await _web3Client!.sendTransaction(_creds, transaction,
        chainId: 1337, fetchChainIdFromNetworkId: false);
    log(result.toString());
    add(DashboardInitialFechEvent());
  } catch (e) {
    log(e.toString());
  }
}
```

---

## Notes
- Ensure the private key and contract address are correctly configured in the code.
- Use Ganache's pre-funded accounts for testing.

---

## License
This project is open-source and available under the [MIT License](LICENSE).

---

## Feedback and Contributions
Feel free to create issues or submit pull requests to improve this project.
