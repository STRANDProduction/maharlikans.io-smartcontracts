// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

interface ISTRANDInformationToken {

    function getName() external returns (string memory);
    function setName(string memory name) external;

    function getText() external returns (string memory);
    function setText(string memory text) external;

    function getData() external returns (bytes memory);
    function setData(bytes memory data) external;
    
}
contract STRANDInformationTokenBasic is ISTRANDInformationToken {
    constructor(string memory name, string memory text) {
        _name = name;
        _text = text;
    }
    string private _name;
    string private _text;

    function getName() public view returns (string memory) {
        return _name;
    }
    function setName(string memory name) public {
        _name = name;
    }

    function getText() public view returns (string memory) {
        return _text;
    }
    function setText(string memory text) public {
        _text = text;
    }

    function getData() public virtual override returns (bytes memory) {
    }
    function setData(bytes memory data) public virtual override {
    }

}
contract STRANDInformationToken is STRANDInformationTokenBasic {
    constructor(string memory name, string memory text, bytes memory data)
        STRANDInformationTokenBasic(name, text) {
        _data = data;
    }
    bytes private _data;

    function getData() public view override returns (bytes memory) {
        return _data;
    }
    function setData(bytes memory data) public override {
        _data = data;
    }
}