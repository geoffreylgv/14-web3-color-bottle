// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

contract ColorBottle {
    uint256 private constant NUM_BOTTLES = 5;
    uint256 private constant MAX_ATTEMPTS = 5;

    uint256[] private correctArrangement;
    uint256 private attemptsLeft;
    bool private gameWon;

    event AttemptResult(uint256 correctPositions);
    event GameReset();
    event GameWon();

    constructor() {
        resetGame();
    }

    function resetGame() private {
        correctArrangement = new uint256[](NUM_BOTTLES);
        for (uint256 i = 0; i < NUM_BOTTLES; i++) {
            correctArrangement[i] = i + 1;
        }
        shuffleArrangement(correctArrangement);

        attemptsLeft = MAX_ATTEMPTS;
        gameWon = false;
        emit GameReset();
    }

    function shuffleArrangement(uint256[] storage arrangement) private {
        for (uint256 i = 0; i < arrangement.length; i++) {
            uint256 randomIndex = uint256(keccak256(abi.encodePacked(block.timestamp, block.difficulty, i))) % arrangement.length;
            uint256 temp = arrangement[i];
            arrangement[i] = arrangement[randomIndex];
            arrangement[randomIndex] = temp;
        }
    }

    function attemptArrangement(uint256[] memory playerArrangement) external {
        require(!gameWon, "Game already won. Start a new game.");
        require(attemptsLeft > 0, "No attempts left. Game over.");
        require(playerArrangement.length == NUM_BOTTLES, "Invalid arrangement length.");

        uint256 correctPositions = 0;
        for (uint256 i = 0; i < NUM_BOTTLES; i++) {
            if (playerArrangement[i] == correctArrangement[i]) {
                correctPositions++;
            }
        }

        attemptsLeft--;

        emit AttemptResult(correctPositions);

        if (correctPositions == NUM_BOTTLES) {
            gameWon = true;
            emit GameWon();
        } else if (attemptsLeft == 0) {
            resetGame();
        }
    }

    function getAttemptsLeft() external view returns (uint256) {
        return attemptsLeft;
    }

    function isGameWon() external view returns (bool) {
        return gameWon;
    }
}
