// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract Estudiante{
    string private _nombre;
    string private _apellido;
    string private _curso;
    uint8 private _cantItems = 0;
    uint8 private index = 0;
    uint8 private _promedio = 0;
    uint8 private _sumaNotas = 0;
    address private _docente;
    string[] private materias;
    mapping(string => uint8) private _notas_materia;

    constructor(string memory nombre_ , string memory apellido_ , string memory curso_ ){
        _nombre = nombre_;
        _apellido = apellido_;
        _curso = curso_;
        _docente = msg.sender;
    }

    function apellido() public view returns(string memory){
        return _apellido;
    }

    function nombre_completo() public view returns(string memory){
        return string(bytes.concat(bytes(_nombre), " ", bytes(_apellido)));
    }

    function curso() public view returns(string memory){
        return _curso;
    }

    function set_nota_materia(uint8 nota, string memory materia) public {
        require(msg.sender == _docente , "Solo los docentes pueden modificar notas");
        _sumaNotas = 0;
        _promedio = 0;
        _notas_materia[materia] = nota;
        materias.push(materia);
        for(uint8 i = 0; i <= _cantItems; i++){
            _sumaNotas += _notas_materia[materias[i]];
        }
        _cantItems++;
        _promedio = ((_sumaNotas)/(_cantItems));
    }
    function nota_materia(string memory materia) public view returns(uint8){
        return _notas_materia[materia];
    }

    function aprobo(string memory materia) public view returns(bool){
        if(_notas_materia[materia] >= 6){
            return true;
        }
        else{
            return false;
        }
    }

    function promedio() public view returns(uint8){
        return _promedio;
    }
}