// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// We can interact with other contracts by declaring an interface

// An interface:
// - cannot have any functions implemented
// - can inherit from other interfaces
// - all declared functions must be external
// - cannot declare a constructor
// - cannot declare state variaables

contract Counter {
    uint256 public count;

    function increment() external {
        count += 1;
    }
}

interface ICounter {
    function count() external view returns (uint256);

    function increment() external;
}

contract MyContract {
    function incrementCounter(address _counter) external {
        ICounter(_counter).increment();
    }

    function getCount(address _counter) external view returns (uint256) {
        return ICounter(_counter).count();
    }
}

// Uniswap example
interface UniswapV2Router {
    function factory() external pure returns (address);

    function WETH() external pure returns (address);
}

interface UniswapV2Factory {
    function getPair(address tokenA, address tokenB)
        external
        view
        returns (address pair);
}

interface UniswapV2Pair {
    function getReserves()
        external
        view
        returns (
            uint112 reserve0,
            uint112 reserve1,
            uint32 blockTimestampLast
        );
}

contract UniswapExample {
    address private router = 0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D;

    address private dai = 0x95b58a6Bff3D14B7DB2f5cb5F0Ad413DC2940658;
    address private weth;
    address private factory;

    event RouterLog(
        address indexed router,
        address indexed factory,
        address indexed weth
    );

    event PairLog(
        address indexed dai,
        address indexed weth,
        address indexed pair
    );

    event ReservesLog(
        uint112 reserve0,
        uint112 reserve1,
        uint32 blockTimestampLast
    );

    constructor() {
        weth = UniswapV2Router(router).WETH();
        factory = UniswapV2Router(router).factory();

        emit RouterLog(router, factory, weth);
    }

    function getTokenReserves() external returns (uint256, uint256) {
        address pair = UniswapV2Factory(factory).getPair(dai, weth);

        emit PairLog(dai, weth, pair);

        (
            uint112 reserve0,
            uint112 reserve1,
            uint32 blockTimestampLast
        ) = UniswapV2Pair(pair).getReserves();

        emit ReservesLog(reserve0, reserve1, blockTimestampLast);

        return (reserve0, reserve1);
    }
}
