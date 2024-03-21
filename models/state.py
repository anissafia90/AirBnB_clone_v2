#!/usr/bin/python3
""" State Module for HBNB project """
from models.base_model import BaseModel
from models.base_model import Base
from sqlalchemy import Column, String
from sqlalchemy.orm import relationship
from models.city import City


class State(BaseModel, Base):
    """ class definition
    Attributes:
        name: input name
    """
    __tablename__ = "states"
    name = Column(String(128), nullable=False)
    cities = relationship("City", cascade="all,delete", backref="state")

    @property
    def cities(self):
        """  Def of cities"""
        from models import storage
        allcities = storage.all(City)
        k = []
        for i, j in allcities.items():
            if j.state_id == self.id:
                k.append(j)
        return k
