#!/usr/bin/python3
""" City Module for HBNB project """
from models.base_model import BaseModel, Base
from sqlalchemy import Column, String, ForeignKey
from sqlalchemy.orm import relationship
from os import getenv as env


class City(BaseModel, Base):
    """ The city class, contains state ID and name """
    __tablename__ = "cities"
    if env("HBNB_TYPE_STORAGE") == "db":
        kwargs = {"cascade": "all, delete-orphan", "backref": "cities"}
        places = relationship("Place", **kwargs)
        state_id = Column(String(60), ForeignKey("states.id"), nullable=False)
        name = Column(String(128), nullable=False)
    else:
        place_id = ""
        user_id = ""
        text = ""
