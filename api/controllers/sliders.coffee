Slider = require("../models/slider")
_ = require("underscore")
user = require("connect-roles")

module.exports =

  options:
    name: 'api/sliders'
    id: 'slider'
    before:
      destroy: user.is("admin")
      create: user.is("admin")
      update: user.is("admin")

# all: (req, res, next) ->
# 	user.is("registered")(req, res, next)

  index: (req, res) ->
    res.send Slider.find()

  show: (req, res) ->
    res.send Slider.findById req.params.slider

  create: (req, res) ->

    slider = new Slider _.extend({}, req.body)

    slider.save (err, slider) -> res.send err or slider

  update: (req, res) ->
    Slider.findById req.params.slider,  (err, slider) ->
      if err
        res.send err
      else if not slider?
        res.send "Missing slider"
      else
        _.extend slider, req.body
        slider.save (err, slider) -> res.send err or slider

  destroy: (req, res) ->
    res.send Slider.findByIdAndRemove req.params.slider		