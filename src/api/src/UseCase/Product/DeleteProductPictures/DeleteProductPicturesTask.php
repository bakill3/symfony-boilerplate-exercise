<?php

declare(strict_types=1);

namespace App\UseCase\Product\DeleteProductPictures;

use App\UseCase\AsyncTask;

final class DeleteProductPicturesTask implements AsyncTask
{
    /** @var string[] */
    private array $pictures;

    /**
     * @param string[] $pictures
     */
    public function __construct(array $pictures)
    {
        $this->pictures = $pictures;
    }

    /**
     * @return string[]
     */
    public function getPictures(): array
    {
        return $this->pictures;
    }
}
