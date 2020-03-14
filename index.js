const express = require('express');
const jwt = require('jsonwebtoken');
const config = require('/configs/config.js')
app = express();

//1 confirma llabe
app.set('llave', config.llave);
//2 la llave es verdadera
app.use(bodyParser.urlencoded({ extended: true}));
//3 funsion de json
app.use(bodyParser.json());
//4 conexion al pueto 3000
app.listen(3000,()=>{
  console.log('servidor iniciando en le pueto 3000')
});
//5 toma de funcion de la extencion t comprueva si es valida si no regresa
app.get('/', function(req, res){
  res.send('Inicio')
});

//6autenticasion de l metodo anterior
app.post('/autenticar', (req,res) => {
  if (req.body.usuario === "asfo" && req.body.contrasena === "hola mundo") {
    const playload = {
      check true
    };
    res
  }
});
