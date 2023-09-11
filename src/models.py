from . import db

association_table = db.Table(
    "cruise_destination_link",
    db.Column("cruise_id", db.ForeignKey("cruise.id"), primary_key=True),
    db.Column("destination_id", db.ForeignKey("destination.id"), primary_key=True),
)


class Destination(db.Model):
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    name = db.Column(db.String(255), nullable=False)
    subtitle = db.Column(db.String(255), nullable=True)
    description = db.Column(db.String(1000), nullable=True)
    cruises = db.relationship("Cruise", secondary=association_table, back_populates="destinations")

    def __str__(self):
        return self.name


class Cruise(db.Model):
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    name = db.Column(db.String(255), nullable=False)
    subtitle = db.Column(db.String(255), nullable=True)
    description = db.Column(db.String(1000), nullable=True)
    destinations = db.relationship("Destination", secondary=association_table, back_populates="cruises")

    def __str__(self):
        return self.name


class InfoRequest(db.Model):
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    name = db.Column(db.String(255), nullable=False)
    email = db.Column(db.String(255), nullable=False)
    notes = db.Column(db.String(255), nullable=False)
    cruise_id = db.Column(db.Integer, nullable=False)
