const Router = require('express').Router;

const api = Router();

api.get('/', (req, res) => {
  res.json([
    { id: 1, name: 'product 1' },
    { id: 2, name: 'product 2' },
  ]);
});

api.get('/:id', (req, res) => {
    res.json({ id: req.params.id, name: `product ${req.params.id}` });
} );

module.exports = api;
