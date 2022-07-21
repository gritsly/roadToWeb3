// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract buyMeACoffee {
    // Event to emit when a Memo is created
    event newMemo(
        address indexed from,
        uint256 timestamp,
        string name,
        string message
    );

    // Memo struct
    struct memo {
        address from;
        uint256 timestamp;
        string name; 
        string message;
    }

    // List of all memos received
    memo[] memos;

    // Address of contract deployer
    address payable owner;

    // Deploy logic - save contract owner address in a constant
    constructor() {
        owner = payable(msg.sender);
    }

    /**
    * @dev buy a coffee for contract owner
    * @param _name name of the coffee buyer
    * @param _message a message from the buyer
    */

    function buyCoffee(string memory _name, string memory _message) payable public {
        require(msg.value > 0, "can't buy coffee with nothing");
        
        // Add the memo to storage
        memos.push(memo(
            msg.sender,
            block.timestamp,
            _name,
            _message
        ));

        // emit a log event when a memo is created
        emit newMemo(
            msg.sender,
            block.timestamp,
            _name,
            _message
        );
    }
    
    /// @dev send the entire balance of tips to the owner
    function withdrawTips() public {
        require(owner.send(address(this).balance));
    }

    /// @dev retrieve all the memos received and stored
    function getMemos() public view returns(memo[] memory){
        return memos;
    }
}
