
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;  // Specifies the version of Solidity to use

contract ExpenseManagerContract {
    address public owner;  // Public variable storing the address of the contract owner

    // Declare events to log deposit and withdrawal transactions
    event Deposit(
        address indexed _from,
        uint _amount,
        string _reason,
        uint _timestamp
    );
    event Withdrawal(
        address indexed _to,
        uint _amount,
        string _reason,
        uint _timestamp
    );

    // Struct to represent a transaction record
    struct Transaction {
        address user;
        uint amount;
        string reason;
        uint timestamp;
    }

    // Maps an address to a user's balance
    mapping(address => uint) public balances;  // Public mapping to store balances by user address
    Transaction[] public transactions;  // Public array to store all transactions

    constructor() {
        owner = msg.sender;  // Set the owner of the contract to the sender's address
    }

    // Modifier to allow only the contract owner to execute specific functions
    modifier onlyOwner() {
        require(
            msg.sender == owner,
            "Only contract owner can call this function"
        );
        _;  // Placeholder for the function body where the modifier is applied
    }

    // Deposit function to add funds to the user's balance
    function deposit(uint _amount, string memory _reason) public payable {
        require(_amount > 0, "Deposit amount must be greater than 0");
        balances[msg.sender] += _amount;  // Add the deposit amount to the sender's balance
        transactions.push(
            Transaction(msg.sender, _amount, _reason, block.timestamp)
        );  // Store the transaction in the transactions array
        emit Deposit(msg.sender, _amount, _reason, block.timestamp);  // Emit the Deposit event
    }

    // Withdraw function to allow users to withdraw funds
    function withdraw(uint _amount, string memory _reason) public {
        require(balances[msg.sender] >= _amount, "Insufficient balance");
        balances[msg.sender] -= _amount;  // Subtract the amount from the sender's balance
        transactions.push(
            Transaction(msg.sender, _amount, _reason, block.timestamp)
        );
        payable(msg.sender).transfer(_amount);  // Transfer the requested amount to the sender
        emit Withdrawal(msg.sender, _amount, _reason, block.timestamp);
    }

    // Get balance of a specific account
    function getBalance(address _account) public view returns (uint) {
        return balances[_account];  // Return the balance of the specified account
    }

    // Get the total number of transactions
    function getTransactionsCount() public view returns (uint) {
        return transactions.length;  // Return the number of transactions
    }

    // Get details of a specific transaction by index
    function getTransaction(
        uint _index
    ) public view returns (address, uint, string memory, uint) {
        require(
            _index < transactions.length,
            "Transaction index out of bounds"
        );
        Transaction memory transaction = transactions[_index];
        return (
            transaction.user,
            transaction.amount,
            transaction.reason,
            transaction.timestamp
        );
    }

    // Get all transactions data
    function getAllTransactions()
        public
        view
        returns (
            address[] memory,
            uint[] memory,
            string[] memory,
            uint[] memory
        )
    {
        address[] memory users = new address[](transactions.length);
        uint[] memory amounts = new uint[](transactions.length);
        string[] memory reasons = new string[](transactions.length);
        uint[] memory timestamps = new uint[](transactions.length);

        for (uint i = 0; i < transactions.length; i++) {
            users[i] = transactions[i].user;
            amounts[i] = transactions[i].amount;
            reasons[i] = transactions[i].reason;
            timestamps[i] = transactions[i].timestamp;
        }

        return (users, amounts, reasons, timestamps);
    }

    // Function to change ownership of the contract
    function changeOwner(address _newOwner) public onlyOwner {
        owner = _newOwner;  // Change the owner of the contract
    }
}
