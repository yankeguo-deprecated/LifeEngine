#!/bin/bash

cson2json ./items_sample.cson > ../LifeEngine/items_sample.json
cson2json ./scene_sample.cson > ../LifeEngine/sample.scene.json

cson2json ./main.scene.cson > ../LifeEngine/Scenes/main.scene.json
cson2json ./ask.scene.cson > ../LifeEngine/Scenes/ask.scene.json
cson2json ./same_name.scene.cson > ../LifeEngine/Scenes/same_name.scene.json
cson2json ./good.scene.cson > ../LifeEngine/Scenes/good.scene.json
cson2json ./bad.scene.cson > ../LifeEngine/Scenes/bad.scene.json
