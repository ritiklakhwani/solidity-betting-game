// SPDX-License-Identifier: MIT

pragma solidity ^0.8.26;

import {VRFConsumerBase} from "@chainlink/contracts/src/v0.8/vrf/VRFConsumerBase.sol";

contract WhatColorYouWant is VRFConsumerBase {
    address public owner;
    uint public minFee = 1 ether;
    bytes32 internal keyHash;
    uint256 internal fee;

    struct Player {
        uint256 balance;
        uint256 lastBetAmount;
        string lastChosenColor;
        string lastLuckyColor;
        bool hasPlayed;
    }

    mapping(address => Player) public players;
    string[] public colors = ["Red", "Yellow", "Blue", "Green"];
    mapping(bytes32 => address) public requestIdToPlayer;

    event ColorChosen(string chosenColor);
    event ResultsChecked(string result, uint256 newBalance);

    constructor(
        address vrfCoordinator, 
        address linkToken, 
        bytes32 _keyHash, 
        uint256 _fee
    ) VRFConsumerBase(vrfCoordinator, linkToken) {
        owner = msg.sender;
        keyHash = _keyHash;
        fee = _fee;
    }

}