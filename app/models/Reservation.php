<?php

class Reservation extends Booking
{
    private $start;
    private $end;
    private $package;
    private $requirement;
    private $host;
    private $popper;
    private $message;
    private $timestamp;
    private $hash;

    public function __construct()
    {
        parent::__construct();
    }

    public function getStart()
    {
        return $this->start;
    }

    public function setStart($start)
    {
        $this->start = $start;
    }

    public function getEnd()
    {
        return $this->end;
    }

    public function setEnd($end)
    {
        $this->end = $end;
    }

    public function getPackage()
    {
        return $this->package;
    }

    public function setPackage($package)
    {
        $this->type = $package;
    }

    public function getRequirement()
    {
        return $this->requirement;
    }

    public function setRequirement($requirement)
    {
        $this->requirement = $requirement;
    }

    public function getHost()
    {
        return $this->host;
    }

    public function setHost($host)
    {
        $this->adults = $host;
    }

    public function getPopper()
    {
        return $this->popper;
    }

    public function setPopper($popper)
    {
        $this->children = $popper;
    }

    public function getMessage()
    {
        return $this->message;
    }

    public function setMessage($message)
    {
        $this->requests = $message;
    }

    public function getTimestamp()
    {
        return $this->timestamp;
    }

    public function setTimestamp($timestamp)
    {
        $this->timestamp = $timestamp;
    }

    public function getHash()
    {
        return $this->hash;
    }

    public function setHash($hash)
    {
        $this->hash = $hash;
    }

    public function requirement()
    {
        return array("No preference", "With photo", "With Photo and Video");
    }
}
