#!/usr/bin/python3
""" Manages DBstorage Class """
from sqlalchemy.orm import sessionmaker, scoped_session, Session
from sqlalchemy import (create_engine)
from models.base_model import Base
from models.amenity import Amenity
from models.review import Review
from models.state import State
from models.place import Place
from os import getenv as env
from models.user import User
from models.city import City

class DBStorage():
    # Class for the database.
    __engine = None
    __session = None

    def __init__(self):
        # Definition of the initial method.

        user = env("HBNB_MYSQL_USER")
        passwd = env("HBNB_MYSQL_PWD")
        host = env("HBNB_MYSQL_HOST")
        db = env("HBNB_MYSQL_DB")
        self.__engine = create_engine('mysql+mysqldb://{}:{}@{}/{}'.format(user, passwd, host, db),
                pool_pre_ping=True)

        if env("HBNB_ENV") == "test":
            Base.metadata.drop_all(self.__engine)

    def all(self, arg=None):
        # return the dictionary of all current objects
        obj_Dict = {}
        if arg:
            query = self.__session.query(arg).all()
            for obj in query:
                strKey = "{}.{}".format(type(obj).__name__, obj.id)
                obj_Dict[strKey] = obj
        else:
            classList = ["Amenity", "Review", "State", "Place", "User", "City"]
            for className in classList:
                obj = self.__session.query(eval(className)).all()
                strKey = "{}.{}".format(className, obj.id)
                setattr(obj_Dict, strKey, obj)
        return (obj_Dict)

     def new(self, obj):
         # Adds a new object to session.
         self.__session.add(obj)

    def save(self):
        # Commit the current session to the DB
        self.__session.commit()

    def delete(self, obj=None):
        # delete an object from the current session
        self.__session.delete()

    def reload(self):
        # Reloads the engine, session and object
        Base.metadata.create_all(self.__engine)
        session = sessionmaker(expire_on_commit=False, bind=self.__engine)
        Session = scoped_session(session)
        self.__session = Session()

    def close(self):
        # close the session
        self.__session.close()

